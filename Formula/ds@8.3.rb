# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "184c5a67f155e6116dce730f28734d1d89fde1b2a5a41be4456149e4e08c4e89"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b36678a078d98d985bf0072e30de34c7c685764fa6c8916d076424391b371bd2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e1664035ac61367da6118e9fdf8030b58be371e6f093a53e1cae9e8c050ff31b"
    sha256 cellar: :any_skip_relocation, ventura:       "45c6880b6f436801f94d8710c21109ee94949b955ea0c27402840e3e7b27a2ab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "07e6905479faf5531640705dafc65b85a100bce31c9136c71650ec667ae2488a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fea652ca219ab74b346a093fd43fc038aad872db0e52ec2e2893de543e223a8a"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
