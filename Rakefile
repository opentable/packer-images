require "fileutils"
require "erb"
require "yaml"

PROVIDERS = ["virtualbox","vmware"]

def write_templates(conf)
  @arch = conf["arch"]
  @version = conf["version"]
  @edition = conf["edition"]
  @iso_name = conf["iso"]
  @iso_checksum = conf["iso_checksum"]
  @output = "windows-#{@version}-#{@edition}-#{@arch}"

  image_dir = "windows/images/#{@output}"
  FileUtils.mkdir_p image_dir

  unattend = ERB.new(File.open("windows/Autounattend.xml.erb", "rb").read, nil, "-")
  File.write("#{image_dir}/Autounattend.xml", unattend.result)

  packer_json = ERB.new(File.open("windows/packer.json.erb", "rb").read, nil, "-")
  File.write("#{image_dir}/packer.json", packer_json.result)

  FileUtils.cp("windows/vagrantfile.template", image_dir)
end

def build_image(conf, provider)
  image_dir = "windows/images/windows-#{conf["version"]}-#{conf["edition"]}-#{conf["arch"]}"
  Dir.chdir(image_dir){
    sh %{packer build -only=#{provider}-iso packer.json}
  }
end

def test_image(conf, provider)
  output = "windows-#{conf["version"]}-#{conf["edition"]}-#{conf["arch"]}"
  image_dir = "windows/images/#{output}"
  vagrant_provider = provider.eql?("vmware") ? "vmware_fusion" : "virtualbox"

  @box = output
  @box_url = "file://#{output}_#{provider}.box"
  @provider = vagrant_provider

  vf = ERB.new(File.open("windows/Vagrantfile.erb", "rb").read, nil, "-")
  File.write("#{image_dir}/Vagrantfile", vf.result)
  FileUtils.rm_rf("#{image_dir}/spec")
  FileUtils.cp_r("windows/spec", "#{image_dir}/spec")

  Dir.chdir(image_dir){
    sh %{vagrant up --provider=#{vagrant_provider}}
    sh %{rspec spec}
    sh %{vagrant destroy --force}
  }
end

desc "Write config"
task :config do
  data = YAML::load_file(File.join(__dir__, 'windows', 'data.yaml'))
  data["windows"].each do |image|
    image.each do |k,v|
      write_templates(v)
    end
  end
end

task :clean do
  FileUtils.rm_rf("windows/images")
  boxes = `vagrant box list | grep windows`.split("\n")
  boxes.each do |box|
    one = box.split(" ")[0]
    two = box.split(" ")[1]
    two = two[1..(two.length-2)]
    sh %{vagrant box remove --provider=#{two} #{one}}
  end
end

desc "packer build"
task :packer_build do
  data = YAML::load_file(File.join(__dir__, 'windows', 'data.yaml'))
  data["windows"].each do |image|
    image.each do |k,v|
      PROVIDERS.each do |provider|
        build_image(v, provider)
      end
      PROVIDERS.each do |provider|
        test_image(v, provider)
      end
    end
  end
end

desc "Build all images"
task :build => [:clean, :config, :packer_build]
