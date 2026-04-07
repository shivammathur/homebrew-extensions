# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "77a0ca5ffa66de29dfa8bd283c636284ea96803a0a3d1907f53d9482659f34da"
    sha256 cellar: :any,                 arm64_sequoia: "10c11ee67568f945516ce4edb806a6f9a284e4c8af6be305445071de30e3f662"
    sha256 cellar: :any,                 arm64_sonoma:  "ab82fc35971c4746664dff4e2be8060922489a7c73c62db8a5ccfa788a3df059"
    sha256 cellar: :any,                 sonoma:        "8b86c18f56e2086794b2c7dfc30e03594c0e40976e6d4f56208224b7710fe64b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1b3c2bb6101c22e91c905b94dcbfba5a51002ece1f2bc40076c5ef1ecf6e94f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fa389ff5b87be8697e70c5cd800034fd271bd7b98d09956299e2c743cc19e62"
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
