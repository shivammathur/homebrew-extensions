# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.3.tgz"
  sha256 "b69c168780527ec73fa3d7986d4279ecce00e184760f6572cc5e450a68b4f201"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8d0b2230a2fc770a4cea585b97f509912c21e3bdf347fcaa4e2711bf5c0bec93"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7b58b831ef012d6b2b6260487007cec1f558267aec6fd313205fd1106fdb3e6d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "68a87ae3d72cda8756fd861f8435640e8637b3cc38b558702beb517477e7b884"
    sha256 cellar: :any_skip_relocation, sonoma:        "ef09ac726045f77dae5f48f7ef6ad98e15c27379d66e19d79c0138c85a7d9760"
    sha256 cellar: :any,                 arm64_linux:   "d02e93f4c1975f10e7e34025fd68bc7841e70ca73a17dd160f804502b0e012db"
    sha256 cellar: :any,                 x86_64_linux:  "ea59172958e7d87e3329d43d721b766aaa5eaa408652708b4b64c22fabeddf34"
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
