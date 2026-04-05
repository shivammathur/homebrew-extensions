# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "2bfa36784c8e7bbd26194b944d52927e8291906e898b75901e00180d09a31ed3"
    sha256 cellar: :any,                 arm64_sequoia: "8f1fef2f823d53d55f89c5475289971e740692754e06af097dec2308a98928ba"
    sha256 cellar: :any,                 arm64_sonoma:  "c04b065f03854fdbe80237aaa550b2fc1a92e20bb9dfc4cdfe7b553a710df7ee"
    sha256 cellar: :any,                 sonoma:        "c884e05d7a139b519079162345b7fdec75e40d43d4ebfbc4c09ce56f4f50bd6a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "311402aaa40c77af6389a846fb04857c4ad8ca5e26e0a17ddfa2f1854c1559c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5567b76359235e62ffafe8a4b55129324c015d279208b66c2521283e43cc8c45"
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
