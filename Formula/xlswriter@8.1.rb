# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7feb0dae527a0325347796807a77f8b56f6ccc7935140ad439aee58d44456459"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "560f00570993a326fd48081473102a58b5ca8f881aa42b74cd7fbd5b09d4321f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e2bfdc5b57feaa7c94c2256c01aaf5eb3bb424b0c1c6fb7ac80e586f2463dbd"
    sha256 cellar: :any_skip_relocation, sonoma:        "facfeb902bd9387a44005781d23c4e36d8bd8bcda01df228a81b3c3bab89f826"
    sha256 cellar: :any,                 arm64_linux:   "2520b94697cc8f335a6c17aaf85d8a3118d8b00e44e459d71f7e6ff82118c3ff"
    sha256 cellar: :any,                 x86_64_linux:  "09400ae8a731b8f103872f047467aae3f888c789da1c977c16c6527aa516377b"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
