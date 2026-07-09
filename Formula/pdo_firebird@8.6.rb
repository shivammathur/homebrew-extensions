# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9dc29aafa5eecc71a9f9e2c7607b588597a91810.tar.gz?commit=9dc29aafa5eecc71a9f9e2c7607b588597a91810"
  version "8.6.0"
  sha256 "a33c8af840b3621e18482dbc5019f45d7e76a1633ec2b134b49e6bfda619b688"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any, arm64_tahoe:   "4786ec187fb89191f5465ca58c679bb7889b13b298da2e5f744f211be104fc30"
    sha256 cellar: :any, arm64_sequoia: "077f114cac5886819e337611e742a5cd201a80e7d26be7ca80e66ac91126ac2d"
    sha256 cellar: :any, arm64_sonoma:  "6ce92bd935532e0179b4217ee8af2fd4b3085647229439d3762207b71f1d15d6"
    sha256 cellar: :any, sonoma:        "ca944828fdc87f861ab3237c8d4d3871b3b71099232ad3be34b7f3da9cb82420"
    sha256 cellar: :any, arm64_linux:   "4ff6fe93bf34e3992e97e8da4336edc0fa4b9f8d2ad81d5c383997f75a0737dd"
    sha256 cellar: :any, x86_64_linux:  "6fbd2da7a40ae62bde8c19558755a6653e7c2d4eb638000c7baab2cc33d56c81"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
