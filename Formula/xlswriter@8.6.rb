# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b88a5a6db69a5d9bca458c70f7c72ef345ed6ffdeb713de31d467a4bf3d0fd4f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4b67e42975509694f95fe6230a4e9f1a8d32a7c2bffd786ed8257b7f6ce47f11"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bd05ef7cd2bf62c8537172557fad65fcd9bd54ee3eda94582ac284a449ca0312"
    sha256 cellar: :any_skip_relocation, sonoma:        "70ca34047a95a6d36824511c3fd83c4646e9e5b49b17ec7b14bc131fb5e9f73c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8c1babe545ecd051395372fc38267a54fa3cfcd9ffeccc25ef059c44ee23f6c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1340fc3daeab21dd651182f20a1a8eafbdb99c0e391fb330d5d8e9e7d3cf1545"
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
