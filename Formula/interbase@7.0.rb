# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "7fda3daeaec27811b4ade353aecdf60841e7b0e9f8af45688572eaba31deacd0"
    sha256 cellar: :any, arm64_tahoe:       "d4dfea61455225f92eb12b852cde8191545979a4da630c883c8660da29d1f082"
    sha256 cellar: :any, arm64_sequoia:     "b3faf6c1b094e1f07538b6df599b0443d60f4064586478afdec7fa2e0789ae20"
    sha256 cellar: :any, arm64_linux:       "d38e313c7b099995fca9c5626e719d2efb80b88552bae0aeeb5a2f2a28f1379b"
    sha256 cellar: :any, x86_64_linux:      "a0def31c7fc0bc8a7d0203f485187067661458a6a7190f8ffe4d68b52b49ee1e"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/67a075e9b509891ae7b95e8ff48e73c16f63a19d.tar.gz"
  version "7.0.33"
  sha256 "29b56e2126d94f5f8fa848194fb4073f33c30ce1f484c94dd52f77de668fe850"
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
