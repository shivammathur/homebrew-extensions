# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT70 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bccbaa9b3fa407d60429025d3957ba63dc2b3d9a1038dacd76fe2b680cbc3754"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6e20aa5721d8d97b992c866845f2096eb11c89ba1defc3d589240f7707d52fd4"
    sha256 cellar: :any_skip_relocation, monterey:       "b58900ea99db93773fe80cc012d12709851100f0d2eec726df1e47d7c0010d12"
    sha256 cellar: :any_skip_relocation, big_sur:        "2fc7721b01075968e6d39443b9d755d83e91aeffec338d6769fa92bf336bf646"
    sha256 cellar: :any_skip_relocation, catalina:       "6e848a43b98f6001442a316b0b61997355eacd6b0de8e917333a03a1ee3f41d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c530f72f4fc589c8500929126f62fbb1708d73b5cb69451812022b241b802949"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
