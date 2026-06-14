# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ec6e5fcf8d1dd507fd510ff979c9d030dc01d42a8e08831298f298d9e8bcdd27"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d2766691330c0a06879761b7445c9c7e052876420a85be490dfb6250b56d7af6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eeb2a9fd99c4ce6328bd02a5279f5b879cb4cc7a10ec760a62849bf2f6f77dd8"
    sha256 cellar: :any_skip_relocation, sonoma:        "d2e4327b8ac9efb498d24e5e3f1d03b4d9317bd00ee3ff4fc933a35467e6d494"
    sha256 cellar: :any,                 arm64_linux:   "429efadbb7e73e8718e71d628d15bbcaf7d120168627e9985f8bfc8f6441648d"
    sha256 cellar: :any,                 x86_64_linux:  "a659a112ceddd0cbe2ddc0061bb698f80d5e0fa4d37b41e4e7aa2c080ec1eb36"
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
