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
    sha256 "ed35568cf420691fecb51fb89fb43dc9cefd1e0c9a1ea22a04305103be24dbf7" => :big_sur
    sha256 "1b53dc4444eade8ecef68ad847457b02c2630fbf32757f6653a3d0f4624d8c2d" => :arm64_big_sur
    sha256 "6554b50300bcf14e36b264372e2d9e079e079a82148a6167f2ebd650a8c66c6d" => :catalina
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
