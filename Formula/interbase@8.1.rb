# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT81 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "171c7aa8b301eb8d86faf832bd6dc63d296d4c14088aa473ad771647f701a330"
    sha256 cellar: :any,                 arm64_sequoia: "d475d39d05b4849b92eb018a293389f29a14bfbc03895315597c65fda18ba4f5"
    sha256 cellar: :any,                 arm64_sonoma:  "e235821ddac0683ce1194139cd1c9e8a2860480d2f02030876f7014ce7837b34"
    sha256 cellar: :any,                 sonoma:        "0d1f62b8045367ed6ec3f42851e155242ebfa4791c103e06d110552808a625d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2fb994c48f0d00a849e2f1626cd38732b74f50382efa90928900a423ae9906e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d05b4fc7af31abb0e63263e5fca190309a823b6f6be66bf3ff4ee574f9ee0cd6"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "019300f18b118cca7da01c72ac167f2a5d6c3f93702168da3902071bde2238f9"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
