# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "61828d751fb9b21103a8c670c731b95797972660f3af896583791a20def4082d"
    sha256 cellar: :any, arm64_sequoia: "03ed7b78c96cdea9e79266223a08536bbb7e8fdd443703b6690b9def4ec831f1"
    sha256 cellar: :any, arm64_sonoma:  "4a7426ecb6490b9aeb02fa5d2ee9b150e7c553751033adfef3fa9b8743dbb710"
    sha256 cellar: :any, sonoma:        "83fbf00a4ab35ce8960b223eecbe41675f0b99c96d77dd8255904ed445ed99bf"
    sha256 cellar: :any, arm64_linux:   "40b19d71c6f651f56c0caa459023356d1f83b8e0204e7f1e8fd45ac9e5c71e35"
    sha256 cellar: :any, x86_64_linux:  "0e8c18b7a14614a86f9c92bad35286160173b80c617c654e75c0f671fb6c4ca2"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
