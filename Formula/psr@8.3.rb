# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT83 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "c41f6473d629cae739cae3623c7ca3cda9c694e8f315ffe1b1b6c9828858a755"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "45074623fa6d4bff9ea0ce27b50e69a3d7ee88acd72db9dcd809d88edf55d717"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6b060a4af943db84556e74f3e7e75c54db66e9ca67a168a3759550ed13247246"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9190b2cb49f12df2ded3648eb739fce043378253aca74170ceafe35fe94f7bdb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9d29876d20c9cdec620b8adf41fcc5c7308f49b98455e537cead3ae64f84f4c6"
    sha256 cellar: :any_skip_relocation, sonoma:         "f46b283130873525a8e6d1edd0d9781a63e3f9274fed74b4540de75b2504562e"
    sha256 cellar: :any_skip_relocation, ventura:        "1a4d03b1d3cb4279993997308ddec21da38855f34b8f7f93626816b2f4d8dd16"
    sha256 cellar: :any_skip_relocation, monterey:       "6223662a0d52b30168b9ef20050f57a4a8a64b72497f322e4cfdace9fda387c8"
    sha256 cellar: :any_skip_relocation, big_sur:        "49a29e4b3d093d895b2ee17080c2d6f3a409622c465d3c17f85cc823e5295f99"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "a64aaa0ef714802160d106595ece5c6831a801aa4007d3270fdc827982601e60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7879fa2614f3f0f27bd934bb49f1d742bc78895aca684103b312b7ce3a7e1df4"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
