# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2ad0b8d3cec0e84fde99cdeea74bb494efad1c7c3e4f81936e3a2ebaf6e29c10"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f470851bdf0b21f4443b4bd4c1c12e323abcd424aef3dc96c926ed774f54722"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "15c6a58cac02bf5cbac093096baa7d5f7bacdde948be401998c466e15b8f616b"
    sha256 cellar: :any_skip_relocation, sonoma:        "ea272e1de3ebf3f49dfb4b6ba46e6d36db61f6749539f14d8a326b4c18a00266"
    sha256 cellar: :any,                 arm64_linux:   "c4aba135e5d600512f54516479312cf9e37c7df901e0f243a983c4da0ad47577"
    sha256 cellar: :any,                 x86_64_linux:  "cd72b36141aa4c64c17c0806a923e721de8afac243c1c0c1cd5a09177bc46ac0"
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
