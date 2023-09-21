# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "81847eaa4c613b301fa04ed0b699988fd7a8d2010300dae375079295d3c9ad68"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "81796afd074595977b69b4c9282289847a1fbb38a7a64e0e5c5318cd6bd96b6b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f3951f370d393ee478629ca757417dc1f42ca746947e9f170e0bdb9bef239a58"
    sha256 cellar: :any_skip_relocation, ventura:        "8dca37ca1d31a7813560cb3311f78e454fe3ac6983d93d5861330d334c7cc1ec"
    sha256 cellar: :any_skip_relocation, monterey:       "7bf3b266220a5bb095cf48405d869c0f4cd0950312948a2c253d347c8668c6ef"
    sha256 cellar: :any_skip_relocation, big_sur:        "0f051217cc95a361a6c5f7e04c8a6ee42a0c8047ad1fc30d08d9dca6616911b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bab8362706f974190e1883eb749a8e2dafc5322098a7b6ccba6743341a7effcf"
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
