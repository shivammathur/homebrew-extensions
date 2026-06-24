# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "19c2c5f1e46d8321a4c5f0ba7d386b83833b57720aebbe9ef741ca493ea499a8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db767cc18f963eae6a804cdf6882f53c090f017c8fc0cecf4df9d110d5e88267"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "51c9c7342122cfefd52b3faf54e01c66ffd7d07d4576589434f04f024e53c26f"
    sha256 cellar: :any_skip_relocation, sonoma:        "4a6e3530725b32fa6385793595d8f93499111ffd51bed8c243c9eacc76ddb58a"
    sha256 cellar: :any,                 arm64_linux:   "e359567426d359344c91141d129acb32e413c7e5fdbbeec200367e14097bbcdb"
    sha256 cellar: :any,                 x86_64_linux:  "581f2018bd84dac90a9043fe52f817ada891088635a0bea25a73b257dbe667e7"
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
