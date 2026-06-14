# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ed345f5a93337a80d4e258cf70dfa3b0993e119e7b206f3712d0e245c67f50cd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c5a35e4ec484e13c78fc39c89e4ce1c861b1d9e30b35f33d90667f8fa80b2f01"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ef98576f25bb093b4db5de7575ec8be7fb2a4fbb449cb869e463847b162fbe27"
    sha256 cellar: :any_skip_relocation, sonoma:        "e721fb7b0efa71567a8cc232c7a9c49bc4d1c8f16b4643ae0a5c5ecbcbff7c99"
    sha256 cellar: :any,                 arm64_linux:   "14277db2f61810257e65db8bafa1c7c01f0bc4943c68deed94110b5293f1b645"
    sha256 cellar: :any,                 x86_64_linux:  "0cf2cfefe31f73662f3e120f2f2086502df2b5285b06cfa5fc75a5b4c520344d"
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
