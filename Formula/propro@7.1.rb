# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT71 < AbstractPhp71Extension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "a94045e159d75b69b8b0c32a174b3f813311ad850a092f350a89d5d294157ddb" => :big_sur
    sha256 "f177ff61783806d7893a9be9c78d073cca1e6887b0033cdd4a994d95d8462981" => :arm64_big_sur
    sha256 "1db0b7085b0cb21f6414f55477530d1e2e61c6ab8d73e51ae4c841d278b6739b" => :catalina
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
