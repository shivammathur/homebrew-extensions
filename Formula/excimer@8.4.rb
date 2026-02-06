# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT84 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f865d03d66404de2f198e968c61a18880d766519e2e93019d526df4b1d4a7c79"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "199957e026222331c2235c689a026c0dce438727bfc7209cc5a553b1ea403d89"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cd4b8a9c477690f6bc489fc251e2677b2eb3d2019d78acbd8bf9149dd134e733"
    sha256 cellar: :any_skip_relocation, sonoma:        "f80f33821f427fba6b4bbe3b419fb3bb959704c7b60624b855a516039ed7147d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c594f90c5493474bc5aa56b558ad3557e229af812ab37dabbbefab65b376379b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29802f13872b2685455a68b3a966f0abdf38abc8c5ae0600e8e6a3f824cc2d87"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
