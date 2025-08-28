# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b038505fe9e6e6feed14c27c1668e698715e65e72df971df9603a6f221d7e6a9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0014e61a9749f7aa86c06a3815b125fd8de325dd36498878465c6932416b730e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "13a88fd4940d5eeee247a078f3254a15b063f85a5b9e77077ff241aebd0e06df"
    sha256 cellar: :any_skip_relocation, ventura:       "30d2c46036b8466325dc1517e1ea3171c81525eea6f207b4307cb38ec7ac8a3f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7eb162aa80c63224676a33f4ca99c5f3f2c2fd28845438fd52ece0c075372a31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7afbbc88d47edd82e70f47161c7b05fc32db08d39fc051ee45738f2a8e5e3237"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
