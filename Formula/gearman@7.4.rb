# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.0.tgz"
  sha256 "2d2a62007b7391b7c9464c0247f2e8e1a431ad1718f9bb316cf4343423faaae9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5e38aabe9b40ce4ba5be5b26722bfee8deee539a111f7c6a70f40d66b825a59c"
    sha256 cellar: :any,                 arm64_sequoia: "095a2911604c93fc3a9a6c0bf904a00491e784ec57f09c973d4d92e2b2dfc3b9"
    sha256 cellar: :any,                 arm64_sonoma:  "f65300dddda1616c6fab90171484ca826805bb5a638211e53be559653ed9b984"
    sha256 cellar: :any,                 sonoma:        "7e1712d1b73c9107859241a664face8128f042455a5fe6928c9969ff32dd15dd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "724654e14efd777a27ea0a922db49908fe19ec8d1bd6990029c92fc77ae5bcde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a8cd30b88265c1abaa8917d6a57f7446e6bad251db7ad50d4650ad09bd6f827"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
