# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4c36ecb7fc60e440aa9b080a4da400e62e0b96c3c34d0769f4adc3d6e7f7c052"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3b666dc86021461386caf90ac2d44a8ebd3a844e46dcff86514df9d192bf5f55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aa88167444c9c629ebf2a20a36ad8d7c5eaa904b3db55e5470b6a9ca28595b11"
    sha256 cellar: :any_skip_relocation, sonoma:        "984a999139d0043529ee3551241a5bfe76fd0b22e93e34af37169bf4776656a9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c3723c1459d9286e49a6d5fe4a259d1bbe505f60a65fab52b6ff3c70e735f0b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1347c47fda390542df7ab8388115b838e311fe7671a6169a56789dc621ba8c47"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
