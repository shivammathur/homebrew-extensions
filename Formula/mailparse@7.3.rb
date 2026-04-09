# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "99b7e4da9bfb3a0213e49eaa6fec2968194162d9ab2bd8e30062fa9f09bee800"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6f853eb62d106f08d7df10e540c1dc294d76f1b423178d807c8ead9c9cd86e31"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f49f35a10c0982458ddbe2d989e2d22052fb877a46979f11f61d351ea87ce58b"
    sha256 cellar: :any_skip_relocation, sonoma:        "c79973170e07c26acc0802b493744f9e98e509778e4df5e36b7cedf6b8e15567"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e5374632440a1b9341ff1b1b52b395cf6b4355c95140ed5c382a372e2845f55f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3d50bdc3bb2d2da27475cd655cbc7dc94158e04ea37041fcf96e883321ffb3b"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
