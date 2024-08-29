# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2ff8184d1d713c28f2d3ceeb61e2c34c0879a9b90ff246ed404e3c38b9ff554c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6e95ba1567a4589989746b57875d2f8ef8691b8a624c440b0b5989eecef31d84"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0df0d26a86ba50e33d0dc2cfac402d20066bd0f77b20667c6afc190c5531aff1"
    sha256 cellar: :any_skip_relocation, ventura:        "6536794c87567ccbe7ea356769af3adb33a0a17064bdca51faf8289379beb872"
    sha256 cellar: :any_skip_relocation, monterey:       "429684449d4acf7425d5dd3370cbbe48e890fbd7f2a6c148e66f9a10dfa061a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fb57f9dc13099975d31778f5f09cd0127c2145d52e2ea404c862cdfdc4f7eea"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
