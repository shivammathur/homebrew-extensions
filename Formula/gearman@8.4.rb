# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "f057e3a6f753a73ebc9b6acb95ca11979897ab7b54d8ea843574ce3d4259b87b"
    sha256 cellar: :any,                 arm64_sequoia: "6d3f365c8af95db8a4f8d7498c30e0d8b909d9c9371a4a86ba90232b214adde0"
    sha256 cellar: :any,                 arm64_sonoma:  "d74ed4e4b3981a36b91f9e49a64ae2161daf5c8725f3236f68b0c70088fdb817"
    sha256 cellar: :any,                 sonoma:        "40f3b287d20cf5add8aa358c481e6b04264484d0144e253b2715ccea56cdac1c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "afb32e9d1b5df44cf125b423703e03af8d26671b42a9c8f73256f2a445e70d36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7781abd83f99d7fa8a4cd35d5d1dadc53edf67ff5dd78c2d3f20a0e0fe28e9f8"
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
