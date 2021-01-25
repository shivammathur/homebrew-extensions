# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT73 < AbstractPhp73Extension
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
    sha256 "3407061402e0a38a9d3d8b948f373c923026453f58fab5d6364f9c9e4c064b2f" => :big_sur
    sha256 "73c5f4a568aff8c93f4f172349836ca7190e28c5e67897a236093ea87fd415e1" => :arm64_big_sur
    sha256 "d0f9b3408b4882ae55d229f9a1debf01fc7c0fe5d1023503a32f0f55f49bbde3" => :catalina
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
