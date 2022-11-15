# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT73 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "470dd60a33efd4f9a99004be813682e53d4c9ad16fb227e70fac3686fb178fe3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8d6114ea6be9c535357579e3a3dca17aecd6d93eb33d841cad248cc9664736a1"
    sha256 cellar: :any_skip_relocation, monterey:       "de81542189d7cab3959a9ea62ad40d26030ba31fdec5505d0cb30e9d55fb64d9"
    sha256 cellar: :any_skip_relocation, big_sur:        "cd93dfeb35115c755dc52e48046826974887b31e24ff4aede6a9ca0efb073e1a"
    sha256 cellar: :any_skip_relocation, catalina:       "f2201f85f7997c55ba4ef70eb52f8d031630ae28960ab14b08d87b4d10443cde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "071c42ba5dac485ca074d118bd4fcc2a678322ac4f0fdec326ca9d0f1acceca5"
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
