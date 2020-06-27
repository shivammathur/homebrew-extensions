require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class ProtobufAT71 < AbstractPhp71Extension
  init
  desc "Protobuf PHP extension"
  homepage "https://github.com/protocolbuffers/protobuf"
  url "https://pecl.php.net/get/protobuf-3.12.2.tgz"
  sha256 "1f4c4927007bebee3622ee0f05a71e7087e0c0f638ec9f3839ba2454fb4d11cb"
  head "https://github.com/protocolbuffers/protobuf.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "c1a1da4bf5b0e4c6f165f2f184a5d9ca4d7439483959b62a5183d3eb8ca26f42" => :catalina
  end

  def install
    Dir.chdir "protobuf-#{version}"
    safe_phpize
    system "./configure", "--enable-protobuf"
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file
  end
end
