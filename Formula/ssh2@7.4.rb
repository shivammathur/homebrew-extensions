# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "e8430547364b32e5b19a351b97561d3893ca040c58969d136b17f3c34b4e7c35"
    sha256 cellar: :any,                 arm64_sonoma:   "eb74a5432f99c67000de5a7873841369d02aec3835fcfe97bf718713c5c1cbea"
    sha256 cellar: :any,                 arm64_ventura:  "a250ed4b09c41ac7ea4df4ca4088e579f62484b99b3a46aa6afb9459fc655759"
    sha256 cellar: :any,                 arm64_monterey: "54af2af41d84b078c41d3956be2f446b0f3a66bfff460a32288d14c3c948b75d"
    sha256 cellar: :any,                 ventura:        "74f59cb0e306ee228c3098a5871acb73bb29487c803c06a920c86e326de7ace5"
    sha256 cellar: :any,                 monterey:       "bd88212f072781431be5f26bf33baf6de30ec754ca6c78266c73d1a0e1590f7f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "bffe684ffb1a6661b99d3c3a93dab22ec55a791f5827098b4cc8a9f37d6c855f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31777545c4d1e836465defeb8dc94f4d61baf83b832d277b4f79389d78faff87"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
