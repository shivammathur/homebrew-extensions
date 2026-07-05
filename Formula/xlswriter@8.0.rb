# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8e56bf9466c1823a78dc108277538e030f77f099a4fe77221eb06896459aa94c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a890730a3ec93d927748adb17807a4ce90b5fa70069f2ef8420081be1eee0fc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ec1bbb72b9238dc656108bc0fcfd063a68c007d69c1dc4ca97862de61372b349"
    sha256 cellar: :any_skip_relocation, sonoma:        "0d9e3d58e25aaac6637b763257bb10ba9718357498093ff89d7645dc49ea6d45"
    sha256 cellar: :any,                 arm64_linux:   "95148dafce249e77e8f76a1a23d39c6fb3fb5d702b7be2ecdccd56553517b33b"
    sha256 cellar: :any,                 x86_64_linux:  "b242c388656fed7d3d9e0f464a7fa5cb4deb85575b4cb61556212bf75e9a6c22"
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
