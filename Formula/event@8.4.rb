# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "26bba868fe21e440aa4091d07c02aedcca33d4cbbc5099e6437fe02f47af4458"
    sha256 cellar: :any,                 arm64_monterey: "f0f10fa1dedc9e3f0c0fa0402bbdbfb45b183e9f10a36a38cfd58ab572d7a03c"
    sha256 cellar: :any,                 arm64_big_sur:  "d3fc6dd26a920f7e04d2646954c6cb254184d86fa1bccaf56a6887f0ae6da720"
    sha256 cellar: :any,                 ventura:        "e1fc54ec6c9e2e594d970b0c411f0a633de95eb3ca056cc9c3245d6c905656f2"
    sha256 cellar: :any,                 monterey:       "3a0c1241eae54b97227767507917ba39dfe48b344da640795d7968aa02611170"
    sha256 cellar: :any,                 big_sur:        "ae6cef5dbb5c445b9a483d8f4df237098432b0c57f681e594350bdf0f21ce114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "84dc5d5d8b7cc5fe777032460ede18da05ae8fe6f137d9e7dfbd08c44860862c"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
