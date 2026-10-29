# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "1833cd1050d7367cb61922c9ea9b06cebcdd2282b4c596ceb51086b2b69553b6"
    sha256 cellar: :any, arm64_tahoe:       "a1bd6d15476402a82d6c69382b2575fe9d826ab8b52a7e3db8ca5073a9b72aa3"
    sha256 cellar: :any, arm64_sequoia:     "b522c04d0277ddf52f7f5bbe44d8016a0cf878d2ae5fbf767d60613880fef207"
    sha256 cellar: :any, arm64_linux:       "158c0d2fe66af12e96bc602839df190994bd75dceaebb8778b0c8bc74cddf7c8"
    sha256 cellar: :any, x86_64_linux:      "35aa52bae2040edfe53377b8071a18ce0b60efab0e98a8d2b740ba9244c49ef4"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
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
