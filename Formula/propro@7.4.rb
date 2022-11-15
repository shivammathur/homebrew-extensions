# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "66b01d47e736c8d576e112687bd292696514a722b15d0730ecb68eeacbcc555b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4c0c8065da60d45699eb4dcfa2e491a12422e22c05e26facfebb374d3a4b817f"
    sha256 cellar: :any_skip_relocation, monterey:       "ca261110911b1bb78f229984c9c1009e4ff35d2fe98148afe342452372b8e371"
    sha256 cellar: :any_skip_relocation, big_sur:        "84f517794539e3475826b9f9ff22bcc44d1d4a0971183dfe13da13ef1b10dfa7"
    sha256 cellar: :any_skip_relocation, catalina:       "de2e1765efff1e3febd53b22306a12a415fdfda63ea65cb73262c6c228c30058"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "566dd734da3d9b68c6a71d7afc092f4df8acae307f2a15551327ec000c323608"
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
