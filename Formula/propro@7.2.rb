# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT72 < AbstractPhp72Extension
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
    sha256 "978200a99be394bc650cb7b6db1d072eb8b78b71095d23121009b2f4eb2a642a" => :big_sur
    sha256 "b77da1519ee89f05780dbef33ee644271174a8a1d6c0ada46e00f5231b8a0809" => :arm64_big_sur
    sha256 "de39d9bafb3451e0ece97761f552824655f9d4ce807002e58be4a73eb25e8495" => :catalina
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
