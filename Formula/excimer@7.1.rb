# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT71 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c4d5a31b6c2b68740a68b1e39834e6ca516b1c31e64a25fbe6b1f99b53ff8807"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5c2a4e090dd7bd1dface808b9b9b3e41cf29579e4cb001d9e0b87ce7cbf0dc79"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bd9fd3a48889a4ff4a567a19b5e8a09e907d536813ba67a5847d6fdaaacbca89"
    sha256 cellar: :any_skip_relocation, sonoma:        "d1627619923192afab225b163c8a5f5f3e8d263e0e516ad8a3eb76762af11781"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "187cab23c6f00a8139028fa559a2eba70275053b61dd1d837d375dccb156d77d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "692aba8dcfb584b0f02310778d1972305814e769e45f51d5a878d322ad69dc64"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
