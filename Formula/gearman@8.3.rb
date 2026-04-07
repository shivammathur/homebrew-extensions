# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f6ee2720f43e7e661a12d30e247dae83212c382562c73e4f6aed3b6a07542123"
    sha256 cellar: :any,                 arm64_sequoia: "7c1e53ec6d686e4fec2f10aa43aa7fa29a3b8d04231b777fa79d1508f48698bd"
    sha256 cellar: :any,                 arm64_sonoma:  "a964b79f1f1ac0c36944d695bb8fe548f7d179e0a713523a195dc4f152425986"
    sha256 cellar: :any,                 sonoma:        "e9f567f8eb90ae1a2f00cae7f4e08db2caa8d4bfb1fc42e18f5d2734bdfb5d09"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e0f05cefeb82706a81bb9fe0136ae957c518c87d9f13b0ebc7a80a6a833bedb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa0279929622339b27f85aaa8a4140fd296dceb6314f6ad15d1871c7e6894136"
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
