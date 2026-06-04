# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.14.0.tgz"
  sha256 "9160c586227f3ae64a282eae5eec4241107087ca66689ac44498fbcd2b3f3c52"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "05df532f2f57c2382bad65c172ac8c9ee285661708ff512fb6bbea2052264e8e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c8a56bba9ab6965064dca032e94e8a6f433d95bb3f78142f75f883d7bb0183dc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "30cf7717756ec98227d668ed038dc61f8a5e9a5700f4fdd0016972889c9b8922"
    sha256 cellar: :any_skip_relocation, sonoma:        "0d74d54e263c30dae88df7d46603dbd3aa9734b7326356c6a6c4842553bd6cfe"
    sha256 cellar: :any,                 arm64_linux:   "5686aab6cbb9bd407c3c728cf04b2f90a827818aa660b5ebb149fa73da88048e"
    sha256 cellar: :any,                 x86_64_linux:  "3c215c41dda9374b4a4b40073955f468498d2fc04d800c41ec49ff9da86c5c9d"
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
