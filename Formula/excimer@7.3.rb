# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3200c6a0dcfa34da373c0e603f64a56aabb4ed6c9c8a6c8a9e14840bb1c77ef9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "acca57f68f265ae23e59f276a9c3978a716f6a810580a77a8c2239510a064e8e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "523992f5bafd873d877edd1a98405e6a9b2894ad5aa0b1a8e83ffec84fa1af91"
    sha256 cellar: :any_skip_relocation, sonoma:        "12e4684c12e886ea780a555df5e54dc8289a6d89bc7180ed29b2554b75ce4706"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2e3d6ceaafd41403ccd03f73cb48670fd2a4a00f7c730780972a0c26ba5ddfd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28298c681126b4a8e07a97e0a1d1405f700aca26b5bb2e84589f7c8de880fca9"
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
