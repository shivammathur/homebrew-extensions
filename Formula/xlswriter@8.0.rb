# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "240abde35106d3e872b2756b9b7aaf18478aeaf390dd2e7ecf6f3dc188cf2d11"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d62c5d61d41b02db6469307113ab568a658e27d27e6f8f8db84137ee2c70e0e9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "300065f70e8ce773a3540fa17d30c30c6ce8c2cd8f1d1716c796d4759e32ab28"
    sha256 cellar: :any_skip_relocation, sonoma:        "e766f7128437e8070be06ea15bc7d0d1cb823e2ad6c24bcc1a5c1efe787be064"
    sha256 cellar: :any,                 arm64_linux:   "249289f35624a4176b4185612a07acbb459e1038364e152e83d42b1cbd25e05f"
    sha256 cellar: :any,                 x86_64_linux:  "d320bc162cb6eb81d43bfc75198691ff46ed1a499ee5d44229cb872e9ad079e8"
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
