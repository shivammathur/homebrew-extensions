# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b9519214804c8e676b1057de4dd24091e972a6c8d85a1ce0a8b27cb656305d29"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8892dc534faed179f39bbc4ef4e2484e5d4319c8d84205aeee42d50271acde2f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "711a1a3f719e8c5e7c576009f3e4e09f567ed7c1c8472a4f4a1e31ad5c1eaea0"
    sha256 cellar: :any_skip_relocation, sonoma:        "eed75351b99f947271b99bb6d3d01d532a6631e5017221bf0d62a96576747bad"
    sha256 cellar: :any,                 arm64_linux:   "619d0bf682cce67ae543444bbeb847a1e7ad484245405126f2916dda7b6301c4"
    sha256 cellar: :any,                 x86_64_linux:  "072018d560338df05731dbff3423d262b237a4cf947d07c65b91cbd81cf5853a"
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
