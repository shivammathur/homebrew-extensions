# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1fbd9fcc6a5b063feefe7b362fd790692694b169588381806931c9ce442707fe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b8a7d9b0f974e73af445917c42ef1c4b54ae00df05ef76c6b1406603c49080e9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1ab8018c8a803aac9c74675ca09e51918fe2f2a277cdf4dfe4d50a5fdddb3837"
    sha256 cellar: :any_skip_relocation, sonoma:        "c373ff9f85e2d1615b1b51cc446b0deafd98728fa9b0f6fea905be372fabf40d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d55bd8e3427a771b734fce12975e9d10910874adec3b0778dfb5bbc964a347d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "accd19b672fee2dc5efbdea65426b34b46ce52c6fe2857933ace7859de151a41"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
