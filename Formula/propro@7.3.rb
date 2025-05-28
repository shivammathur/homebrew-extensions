# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT73 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/propro/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "e8e08769591e6242a9968625c31d14cf94e97dcfa7111e4a23ae805b96a2910d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b4664e9c3bbab46f95abe704eb7c36d7c7ecf3676db44afeb1d7f4b16f964e0a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "54a6df11e055d0d7302b2686d392aa92fb5c9283ff57d8babb4c6cc4583f4be8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1f58cbdb9b15e98151b1c2b7844554ca264f2bfbe4f398381bb286bf3655faf6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d5eed500672f357acaf39e8d469b305d466b9aa18334a8a05fb1cacfac96c5ae"
    sha256 cellar: :any_skip_relocation, ventura:        "1101b789fce67e0da0b28482aa9723f1cdcbc9f759125552de07f47721db8eca"
    sha256 cellar: :any_skip_relocation, monterey:       "b5c637d7d4bc6892f2d385f516276c4e4e1b61c8bd93fc497934df42890b292f"
    sha256 cellar: :any_skip_relocation, big_sur:        "191816e84fbc2c5b7bdf60edd6dfce2ce52430f090f82449b920b5ba0806bfb3"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "31f955d9dfcf4813854deea9771f17eeb11d19a6c63afe1b0b8526b74a46f0f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "accac3beb9db1ae1b8fbaf164f029000b9b571d336fa39d3c17b251d51da8e6d"
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
