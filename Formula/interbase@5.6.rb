# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "9ff0b7d5297fd6fcb7fa44ac02b423300675ced41b081ddb617710c4c89598b1"
    sha256 cellar: :any, arm64_tahoe:       "bfa3b181eccf1ede489c66303b83111b0e6cfad138e59bd2f5e5a72579f7a9ec"
    sha256 cellar: :any, arm64_sequoia:     "3056503151ff47778d0eb0feb31e3c1b2b49b3b030ade0ad15221f8507333cc6"
    sha256 cellar: :any, arm64_sonoma:      "5087dd25598cb7d1d6adec86cda032ec752a7953d91a1f9740ca61ea6a99cd61"
    sha256 cellar: :any, sonoma:            "415a874397a9bd6a1461675c57d1650e0b15feaac3a5396e1d75a10447eb2ad3"
    sha256 cellar: :any, arm64_linux:       "8c706a38a2c596e2fac184543b4f63596ba9f1a79afc069ad4e714eb2a98198f"
    sha256 cellar: :any, x86_64_linux:      "6d9742def2ee0b9c90a31a3d0dfad8f149df81a93b39d0845e7dc57508ade49b"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f0da72721b16b74c602d3c80f527e07d1cdd49a.tar.gz"
  version "5.6.40"
  sha256 "595bb86a07ce587ae98a04cf1d3cb23f2280a90867a11cc312d67a4b1e87911a"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-int-conversion"
      ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
