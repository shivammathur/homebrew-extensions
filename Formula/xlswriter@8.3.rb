# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dbc6d48a522d9fb9fcdedf13a3eff837761fc8ab38c51be83bd1b80ca3bbe8d6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f1980172f046c7de0b7ab1277feb96fc8cf27fc84a4948701e85ee40f22b7016"
    sha256 cellar: :any_skip_relocation, ventura:        "d4b56684d26ef8d11cedadff9ac278228ab5cef4bb066aa29a208a8855a1b674"
    sha256 cellar: :any_skip_relocation, monterey:       "e263fde9517b712390c2048cc6140eada282e09e3fde1556499fe62400ae229a"
    sha256 cellar: :any_skip_relocation, big_sur:        "2cc2e9fb2ec20c4b7aa871aa8bc91627d918a46f71c14db880cbb4caa5207092"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5930eed620bb60eee9ee848e66a88bc466304e66126bddcc508cd571d684fe04"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
