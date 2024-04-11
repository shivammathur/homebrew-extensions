# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "ae2618bfa4d361fa05b4675bcc2ab4a95a026aca93989b0e24b782d5e8aacc66"
    sha256 cellar: :any,                 arm64_ventura:  "4667b768b5dbedae6a7918e1c112eab388eb10958ae3f7adc46dd4da65b78258"
    sha256 cellar: :any,                 arm64_monterey: "81be7cb1dc4ae58feaa9f2ec808059d4744ca510f08c958a389ab0c64434e2ae"
    sha256 cellar: :any,                 ventura:        "a33501f3671f74489d3633329d201e9311bd92d2611f9540f0d5b4a6dbd22339"
    sha256 cellar: :any,                 monterey:       "2ec506876e0eb0d5884999d133169599785cd822f4634e2cc756914599c59e1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4601592b73406f0603f81d81e879d064f2a1c3d044c3d3898d8018bad1fff953"
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
