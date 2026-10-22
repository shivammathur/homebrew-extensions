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
  url "https://github.com/shivammathur/php-src-backports/archive/85accd17bbbe667724a4901e0b3eec4f5fabddaa.tar.gz"
  version "7.1.33"
  sha256 "f5c5326b49a1b2c0fb6049ba6e237e7ad3df4a3f75885509f591b71c15232f44"
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
