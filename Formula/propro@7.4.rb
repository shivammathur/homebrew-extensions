# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT74 < AbstractPhp74Extension
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
    sha256 "9d04dd237f0352806f77c8b50c0c0f94067288d88b04380132923e731110476d" => :big_sur
    sha256 "0de4a541bce5a2cbda427862ac7221b8af5f5a4c2efeba628b71e110a1646b61" => :arm64_big_sur
    sha256 "6b4d5901d230a7316c4be3991c29b3997115e147bc40dba88b54ca7d1d1ebc44" => :catalina
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/propro.so"
    write_config_file
  end
end
