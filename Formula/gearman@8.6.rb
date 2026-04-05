# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "19e05556bfbbf2c4c336f38b69f1069a5d48bbacc6fb6872eed385c0d9b76d7e"
    sha256 cellar: :any,                 arm64_sequoia: "caa2c6d8893fbab629a63b1dd40dda6e5d80ca1a2237d3f3f8f7d53bbb0370f4"
    sha256 cellar: :any,                 arm64_sonoma:  "138d7e2d03015b3521508cb573c271dee1bb1d562415a106853e0dd9b5b64a61"
    sha256 cellar: :any,                 sonoma:        "3ac40d7d8ecf48bcdb137bb0e7b6a7344419b6fa5750fb05fa48308fa345054b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f0279da82cd980aec548ab79986f32adc90d06dd02ac56773e5711b651dc539"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e791869a81181847da58a1d23ae8ff5d74035ef4bfe3258f9aa686f6221d5ad1"
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
