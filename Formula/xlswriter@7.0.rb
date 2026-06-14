# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "25ac7a0f127cf39773506f1e10d3e3d8882e8478fe16aab3c046c5ec21a2bc3a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4f8149d5316259da7a06e4806cdf1466e8c5789ffdc155b365c3df2b0d34ae5f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dc4f2971ca19e568ade97188bc4dd78d05d870c88ce8d5f824e7dfd5181b71cb"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd9dd74b93e648dcf4d83e6efee5789fb0ea69ea10196512578d51662890664b"
    sha256 cellar: :any,                 arm64_linux:   "39343cb2f2d044d73eb18fbe54a86500d4a4b3ce566b2f81909c3940272c010f"
    sha256 cellar: :any,                 x86_64_linux:  "0993939e77a9da887fe2522fd3799b117b8e5ad58abded981cec2d0bcefb413b"
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
