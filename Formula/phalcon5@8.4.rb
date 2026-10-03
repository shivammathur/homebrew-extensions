# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4e617d285509c4c16ad87aad4d9f4b21e1553cf749093cfaf694f9ba22266ad0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c4b6a0f1d741c88d7977db4368bbfd5a779239cc4ee61d543904e98a40c79e47"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "145f81c62205e923be869adb66d7723cc46042f2fe607b0fd4d87a074d9e4bac"
    sha256 cellar: :any,                 arm64_linux:       "60a7a19a446cb6c6da85150163e95a2595ee769c5778855dd208dfe87119f207"
    sha256 cellar: :any,                 x86_64_linux:      "c5a228e3d5601da1baf62b63e419755d2f75f214758e1d80ab27e02b7a78261f"
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
