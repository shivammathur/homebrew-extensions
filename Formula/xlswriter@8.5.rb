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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9f0e07422370731e570bc3115e6c83a5304371eb08a5f78b0f122eeb9d6dd586"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b09aac84f6c8b04e4e4be6bdb5483f36c534d089a5425175d46cee561feaaeac"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "55915a033be17c63d17fdc602a040bdd52e7e0544c32dba6d412e55c914939a7"
    sha256 cellar: :any_skip_relocation, sonoma:        "9410234352c4a76996ebda1817e9631236bbdf61488740bbcfb96abd01dc71e7"
    sha256 cellar: :any,                 arm64_linux:   "a883cceb8f8ffe91b092c53daedda680769e688465a6ed5aa5094c1e57773751"
    sha256 cellar: :any,                 x86_64_linux:  "ba5814c42afd1f6b7ab091b8327f39605db6813102a8f9f4b0f4e6eaca7a2b0e"
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
