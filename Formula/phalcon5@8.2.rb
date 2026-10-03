# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.1.tgz"
  sha256 "328bc4998d56f287dfc8ada9e57725fc2b2fa2ec5f56545461a60af9d7905167"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "438f3fb2cac3d67975c62dbf2ffe91184bbd3e566d0df23204285374cedea4c7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c37974d585fdceb06fa0d7fedc05d92eda02e5a321c17d7881bf56e095997c33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "eccfa3646226a7cfc376b46efa7e371e07a7b651c67fb9160331692a93f62004"
    sha256 cellar: :any,                 arm64_linux:       "fa56c57559d929f07ab5f2ff3f20f688c9ab3ea42eb57bbedbe86fe0d10aa9fa"
    sha256 cellar: :any,                 x86_64_linux:      "6bc11c187e580cd1d0d80ece9daa47ed73f62dbf690445ef09084691e58a2ace"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
