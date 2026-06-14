# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fc6469cc9e8fd2a9223f1b1e23ad3ecc283fb69f1c5fbff81a0e79a6bf954075"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "339128d43cb71c6e56247e5998e4ced21b2fdcd6ae84fce55b7e9af7e9833377"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c78f9d55e5337c0d36dbf88cf9024cc11c4d3a4c2d3f00f8edddfffa31864787"
    sha256 cellar: :any_skip_relocation, sonoma:        "c4b8f3ef0016f4f09b4877d7b6fdc4368b2434040b24e6be6047e488352e8359"
    sha256 cellar: :any,                 arm64_linux:   "95bdc808a72c6440de6b70078d5894ba7bda656b3094da0aec802b6e1c2e8972"
    sha256 cellar: :any,                 x86_64_linux:  "18d61cd1a9c0b0b4eeb706ebc957975fbe1d5cb7f1f519fa6eeeb9e3c96d34b7"
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
