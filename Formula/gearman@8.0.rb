# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b7c8f4e3bd324d6f7fbf1e5f793f1f5874ba6d5c62eb2e9ecc2edc4a308809e6"
    sha256 cellar: :any,                 arm64_sequoia: "4c53a685f4e61d20f7bb90e1393117d54122a717231716f32d0c26a822c61bf8"
    sha256 cellar: :any,                 arm64_sonoma:  "2b6197f54a128d10ba87d644f501864edc749af0687ae47391a0bc2a0e28cda4"
    sha256 cellar: :any,                 sonoma:        "7a2d817a22476509e81edefcc95c1681f7abf322f6b57b2f6a31d24ccd2d3e71"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4a576ade5cccb539ef9cfbbdef1c7196944b30abec49237c6a43193313f8359e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be9a63cb3b2ec7a5dca49ab177f0e885f12148e9ca97984ef7781cd5c044e46d"
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
